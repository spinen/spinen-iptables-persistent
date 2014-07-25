#!/usr/bin/env bats

@test "ufw binary is no longer found in PATH" {
    run which ufw
[ "$status" -eq 1 ]
}

@test "iptables-persistent has been installed." {
    run stat /usr/share/doc/iptables-persistent
[ "$status" -eq 0 ]
}

@test "Check that rules.v4 has been created" {
    run stat /etc/iptables/rules.v4
[ $status = 0 ]
}