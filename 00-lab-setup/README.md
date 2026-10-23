# 00 — Lab setup

## Context
Before any attack makes sense, the environment has to exist: an isolated AD domain with enough
realistic content to make the attack chain meaningful.

## Architecture

| Host | Role | Address |
|------|------|---------|
| **DC**   | Domain controller + DNS, domain `youssefelazhar.be` | `172.18.10.100` |
| **MS1**  | Member server: DHCP, NAT to the internet, internal website | `172.18.10.101` |
| **PC1**  | Windows client | IP via DHCP |
| **KALI** | Attacker machine | `172.18.10.105` |

All four VMs sit on a VirtualBox host-only / internal network in the `172.18.10.0/24` range. MS1
provides DHCP for the clients and NAT so the lab can reach the internet when needed (updates, tool
installs), while staying walled off from any real network.

## Build outline
1. Promote DC to a domain controller for `youssefelazhar.be`, with the DNS role.
2. Join MS1 and PC1 to the domain. MS1 runs DHCP, NAT and a small internal web service.
3. Point KALI at the lab network with a static address (`172.18.10.105`).

## Populating the domain

The domain is bulked up with **BadBlood**, which creates thousands of users, groups and OUs and
sprinkles misconfigured ACLs across them. That gives the lab the shape and noise of a real
directory instead of a handful of tidy test accounts.

```powershell
# Run on the DC, from an elevated PowerShell
.\Invoke-BadBlood.ps1
```

On top of BadBlood, a few accounts were seeded with realistic weak passwords and one was left with
Kerberos pre-authentication disabled, so the AS-REP Roasting step has something to land on.

> **Honesty note.** The weak passwords and the pre-auth-disabled account were set on purpose. A
> freshly installed AD does not hand these to you; the seeding is what makes the chain reproducible
> as a demonstration. Every write-up that depends on it says so.

## Reference
- BadBlood — https://github.com/davidprowe/BadBlood
