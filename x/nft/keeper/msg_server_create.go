package keeper

import (
	"context"

	"cudos.org/cudos-node/x/nft/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

func (k msgServer) Create(goCtx context.Context, msg *types.MsgCreate) (*types.MsgCreateResponse, error) {
	ctx := sdk.UnwrapSDKContext(goCtx)

	// TODO: Handling the message
	_ = ctx

	return &types.MsgCreateResponse{}, nil
}
