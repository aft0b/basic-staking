--- FILE: scripts/run-example.sh
#!/usr/bin/env bash
# Example commands to run in a Clarinet console session
# Start Clarinet locally in another terminal: `clarinet console`
# Then paste these commands into the clarinet console to interact.

echo "-- call stake u100 from account_1 --"
# In clarinet console, accounts are like 'account_1' etc. Example:
# ::stx::contract-call? .staking stake u100


echo "-- call withdraw u50 from account_1 --"
# ::stx::contract-call? .staking withdraw u50


echo "-- read stake of account_1 --"
# ::stx::contract-call-read? .staking get-stake 'ST000000000000000000002AMW42H'


echo "-- read total staked --"
# ::stx::contract-call-read? .staking get-total-staked
