--reconnect on disconnect but not when you log out

function eventReconnect()
    if not Nf.logOut then
        reconnect()
    else
        Nf.logOut = false
    end
end
