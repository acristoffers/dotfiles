function update-flutter
    if test (uname -s) != "Darwin"
        return
    end

    title Updating Flutter

    if not type -q flutter
        echo "flutter is not installed"
        exit 1
    end

    flutter upgrade
end
