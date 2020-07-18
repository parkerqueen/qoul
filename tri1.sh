. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "           tri1 : Deltas + Delta-Deltas Training & Decoding               "
echo ============================================================================

steps/align_si.sh --boost-silence 1.25 --nj "$training_nj" --cmd "$train_cmd" \
 data/train data/lang exp/mono exp/mono_ali

steps/train_deltas.sh --cmd "$train_cmd" \
 $numLeavesTri1 $numGaussTri1 data/train data/lang exp/mono_ali exp/tri1

utils/mkgraph.sh data/lang exp/tri1 exp/tri1/graph

steps/decode.sh --nj "$decoding_nj" --cmd "$decode_cmd" \
 exp/tri1/graph data/test exp/tri1/decode