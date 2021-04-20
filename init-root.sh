rm -R ./data/*
rm -R ./data/.*

MONIKER="cudos-root-node"
CHAIN_ID="cudos-network"
UNBONDING_TIME="1814400s"

cudos-noded init $MONIKER --chain-id=$CHAIN_ID

sed -i "104s/enable = false/enable = true/" /usr/cudos/data/.cudos-node/config/app.toml
sed -i "s/laddr = \"tcp:\/\/127.0.0.1:26657\"/laddr = \"tcp:\/\/0.0.0.0:26657\"/" /usr/cudos/data/.cudos-node/config/config.toml

# setting unbonding time
cat /usr/cudos/data/.cudos-node/config/genesis.json | jq --arg UNBONDING_TIME "$UNBONDING_TIME" '.app_state.staking.params.unbonding_time = $UNBONDING_TIME' > /usr/cudos/data/.cudos-node/config/tmp_genesis.json && mv /usr/cudos/data/.cudos-node/config/tmp_genesis.json /usr/cudos/data/.cudos-node/config/genesis.json


cudos-noded keys add validator01 --keyring-backend test

VALIDATOR_ADDRESS=$(cudos-noded keys show validator01 -a)

cudos-noded add-genesis-account $VALIDATOR_ADDRESS 100000000000stake

cudos-noded gentx validator01 100000000stake --chain-id $CHAIN_ID --keyring-backend test

cudos-noded collect-gentxs


