# enable TouchID for sudo
function ensure_touchid_pam
    if ! sudo grep -q "pam_tid.so" /etc/pam.d/sudo
        sudo cp /etc/pam.d/sudo /etc/pam.d/sudo.bak
        printf "auth optional /opt/homebrew/lib/pam/pam_reattach.so\nauth sufficient pam_tid.so\n$(sudo cat /etc/pam.d/sudo)" | sudo tee /etc/pam.d/sudo
    end
end