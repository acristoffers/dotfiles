function update-apt
    if test (uname -s) != Linux
        return
    end

    if type -q aptitude
        title Updating Aptitude

        sudo aptitude update -y
        sudo aptitude full-upgrade -y
        sudo aptitude clean -y
    else if type -q apt-get
        title Updating Apt-Get

        sudo apt-get update -y
        sudo apt-get full-upgrade -y
        sudo apt-get autoremove -y
        sudo apt-get clean -y
    end
end
