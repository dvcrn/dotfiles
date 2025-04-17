# ~/.config/fish/functions/ai_rename.fish

function ai_rename --description "Renames a file using AI based on its content"
    # --- Configuration ---
    # You can change the model or temperature here if needed
    set -l model claude-3-5-sonnet-20241022
    set -l temperature 0.8
    set -l user_prompt "Generate a concise filename based on the content of the provided file."
    # --- End Configuration ---

    # Parse arguments
    set -l auto_confirm false
    set -l files

    # Process arguments
    for arg in $argv
        switch $arg
            case "-y" "--yes"
                set auto_confirm true
            case "-*" "--*"
                echo "Unknown option: $arg" >&2
                echo "Usage: ai_rename [-y|--yes] <filename>" >&2
                return 1
            case "*"
                set -a files $arg
        end
    end

    # Check if anthropic-cli is installed
    if not command -q anthropic-cli
        echo "Error: 'anthropic-cli' command not found." >&2
        echo "Please install it (e.g., pip install anthropic-cli) and ensure it's in your PATH." >&2
        return 1
    end

    # Check for input files
    if test (count $files) -eq 0
        echo "Usage: ai_rename [-y|--yes] <filename1> [filename2 ...]" >&2
        echo "Example: ai_rename 'My Document.pdf' 'Another File.jpg'" >&2
        echo "Use -y or --yes to automatically confirm rename" >&2
        return 1
    end

    # Process each file
    for original_file in $files
        # Check if the file exists
        if not test -f "$original_file"
            echo "Error: File not found: '$original_file'" >&2
            continue
        end

        # Extract the original file extension
        set -l original_extension ""
        if string match -q "*.?*" "$original_file"
            # Use single quotes for the regex pattern to avoid variable interpolation with $
            set original_extension (string match -r '\.[^\.]+$' "$original_file")
        end
        
        # Get current date for the prompt fallback
        set -l current_date (date +%Y-%m)

        # Define the system prompt with the dynamic date
        # Update the prompt to request consistent file extension handling
        set -l system_prompt "You are a program designed to generate filenames that could match the given text. Output exactly 1 filename that could fit the content and nothing else. Include a date in the format yyyy-mm at the beginning of the filename if present in the content, otherwise use the current date, which is $current_date. The date could be in Japanese (Reiwa x年x月), convert this into western dates. DO NOT include a file extension in your response, as the original extension will be preserved. Separate words by space. No preamble, no extra output, only output the filename. Keep it concise. If the file is a booking confirmation, include relevant city information and booking dates (mm/dd format, no year) (with -> arrow). For bus/flight tickets, include departure -> destination. For airports, only airport code, NO city name. If the name is 'David', dont include it. If the content is mainly in Japanese, the title should be in English, but with a Japanese version followed in brackets. For example 2024-12 Medical Insurance Qualification Information (医療保険資格情報)"

        echo "Asking AI to suggest a name for '$original_file'..."

        # Call anthropic-cli and capture the suggested name
        # Use 'command string trim' to remove leading/trailing whitespace/newlines
        # Use '--' with string trim just in case output starts with '-'
        set -l suggested_name_raw ""
        set -l anthropic_status 0
        # Capture stderr as well to potentially show errors from anthropic-cli
        set suggested_name_raw (anthropic-cli -g user "$user_prompt" -i "$original_file" -m "$model" -s "$system_prompt" -t "$temperature" 2>&1)
        set anthropic_status $status

        # Check if anthropic-cli command failed
        if test $anthropic_status -ne 0
            echo "Error: anthropic-cli failed with status $anthropic_status for '$original_file'." >&2
            # If stderr was captured and is not empty, print it
            if test -n "$suggested_name_raw"
                echo "anthropic-cli output/error:" >&2
                echo "$suggested_name_raw" >&2
            end
            continue
        end

        # Trim whitespace from the successful output
        set -l suggested_name (string trim -- "$suggested_name_raw")

        # Check if the suggested name is empty
        if test -z "$suggested_name"
            echo "Error: AI did not return a suggested name for '$original_file'." >&2
            continue
        end

        # Strip any extension that might have been included despite instructions
        # Use single quotes for the regex pattern
        set -l base_name (string replace -r '\.[^\.]+$' "" -- "$suggested_name")
        
        # Basic sanitization: replace slashes which are invalid in filenames on most systems
        # You might want to add more replacements (e.g., :, *, ?, ", <, >, |) if needed
        set -l sanitized_name (string replace -r '/' '_' -- "$base_name")
        
        # Create the final name by combining the sanitized name with the original extension
        set -l final_name "$sanitized_name$original_extension"

        # Prevent renaming to the exact same name
        if test "$original_file" = "$final_name"
            echo "Suggested name '$final_name' is the same as the original. No rename needed."
            continue
        end

        # IMPORTANT: Check if a file with the new name already exists to prevent overwrite
        if test -e "$final_name"
            echo "Error: A file or directory named '$final_name' already exists. Skipping rename." >&2
            continue
        end

        # If auto_confirm is true, skip the confirmation prompt
        if test "$auto_confirm" = "true"
            if mv -- "$original_file" "$final_name"
                echo "Successfully renamed '$original_file' -> '$final_name'"
                continue
            else
                echo "Error: Failed to rename '$original_file' to '$final_name'. Check permissions or other issues." >&2
                continue
            end
        end

        # Print the prompt
        echo ""
        echo -n "Rename '$original_file' to '$final_name'? [y/N] "
        
        # Use stty to configure the terminal for single-key input
        # Save the current terminal settings
        set -l old_stty (stty -g)
        
        # Configure terminal for immediate character input without requiring Enter
        stty -icanon -echo
        
        # Read a single character
        set -l confirm_char (dd bs=1 count=1 2>/dev/null)
        
        # Restore the terminal settings
        stty "$old_stty"
        
        # Print a newline after input
        echo ""
        
        # Proceed only if user confirms with 'y' or 'Y'
        if test "$confirm_char" = "y" -o "$confirm_char" = "Y"
            # Perform the rename
            # Use '--' to handle filenames that might start with a dash
            if mv -- "$original_file" "$final_name"
                echo "Successfully renamed '$original_file' -> '$final_name'"
            else
                echo "Error: Failed to rename '$original_file' to '$final_name'. Check permissions or other issues." >&2
            end
        else
            echo "Rename cancelled by user for '$original_file'."
        end

    end
end
