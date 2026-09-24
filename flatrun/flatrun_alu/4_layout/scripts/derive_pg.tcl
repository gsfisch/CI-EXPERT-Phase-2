# define logical 0 and 1
derive_pg_connection -power_net $MW_POWER_NET -power_pin $MW_POWER_PORT -ground_net $MW_GROUND_NET -ground_pin $MW_GROUND_PORT

derive_pg_connection -power_net $mw_logic1_net -ground_net $mw_logic0_net -tie

