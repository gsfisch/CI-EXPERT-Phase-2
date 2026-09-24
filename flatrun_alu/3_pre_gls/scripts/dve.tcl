gui_open_db  -file  ./gate.vpd
gui_open_window Wave
gui_list_add -id Wave.1 -after {New Group} { TEST_TOP } -insertionbar
gui_zoom -window Wave.1 -full
gui_open_window List
gui_lst_add -id List.1 { TEST_TOP }
