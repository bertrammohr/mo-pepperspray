cfg = {
    keys = {
        21, -- SHIFT
        304, -- H
    },
    job = "Politi-Job",
    msgs = {
        confirm = "Pebersprayede!",
        deny = "Ingen i nærheden!",
        peppered = "Du fik peberspray!"
    },
    pepperspray = {
        duration = 10000,
        camerashake = 0.5,
    },
    animations = {
        peppering = {
            dict = "anim@mp_player_intupperspray_champagne",
            anim = "enter",
        },
        peppered = {
            dict = "anim@amb@business@cfm@cfm_machine_oversee@",
            anim = "cough_spit_operator",

            sprintdict = "move_characters@trevor@cough_run",
            sprintanim = "cough_run",
        }
    }
}