# Active Directory Attack & Defense — Home Lab

A deliberately vulnerable Active Directory environment, built from scratch in VirtualBox on an
isolated network. The lab shows both halves of the job: breaking into an AD the way an attacker
would, then closing the holes and proving the fix held.

> **Scope.** Everything here runs on an isolated lab network. None of it is connected to a real or
> production environment, and it should never be presented as such.

## Architecture

| Host | Role | Address |
|------|------|---------|
| **DC**   | Domain controller + DNS, domain `youssefelazhar.be` | `172.18.10.100` |
| **MS1**  | Member server: DHCP, NAT to the internet, internal website | `172.18.10.101` |
| **PC1**  | Windows client | IP via DHCP |
| **KALI** | Attacker machine | `172.18.10.105` |

The domain is filled out with [BadBlood](https://github.com/davidprowe/BadBlood), which generates
thousands of users, groups and OUs along with a mess of misconfigured ACLs. On top of that, a
handful of accounts were given realistic weak passwords so the attack chain can be followed end to
end. That seeding is deliberate and the methodology says so plainly. The lab is a demonstration; a
freshly installed AD does not hand you these shortcuts on its own.

## Attack chain

```
Recon (ping, nmap)  ->  Enumeration (kerbrute)  ->  AS-REP Roasting (GetNPUsers + hashcat)  ->  valid domain credentials
```

## Contents

| Step | Folder | Status |
|------|--------|--------|
| 00 — Lab setup | [`00-lab-setup/`](00-lab-setup/) | drafted |
| 01 — Recon & enumeration | [`01-recon-enumeration/`](01-recon-enumeration/) | done |
| 02 — Kerberoasting | [`02-kerberoasting/`](02-kerberoasting/) | planned |
| 03 — AS-REP Roasting | [`03-asrep-roasting/`](03-asrep-roasting/) | done |
| 04 — ACL abuse | [`04-acl-abuse/`](04-acl-abuse/) | planned |
| 05 — Lateral movement | [`05-lateral-movement/`](05-lateral-movement/) | planned |
| 06 — Domain dominance | [`06-domain-dominance/`](06-domain-dominance/) | planned |
| 07 — Hardening | [`07-hardening/`](07-hardening/) | planned |
| 99 — Pentest report | [`99-report/`](99-report/) | planned |

Each attack folder pairs the technique with its remediation: how the attack works, what the attacker
gains, how to shut it down, and proof that the fix actually broke the attack.

## CV line

Built and documented a deliberately vulnerable Active Directory lab (VirtualBox, isolated network):
ran a full attack chain from recon to credential access (nmap, kerbrute, AS-REP Roasting with
Impacket and hashcat) and wrote the matching remediations with before/after verification.
