. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "                     MonoPhone Training & Decoding                        "
echo ============================================================================

steps/train_mono.sh  --nj "$training_nj" --cmd "$train_cmd" data/train data/lang exp/mono

utils/mkgraph.sh data/lang exp/mono exp/mono/graph

steps/decode.sh --nj "$decoding_nj" --cmd "$decode_cmd" \
 exp/mono/graph data/test exp/mono/decode