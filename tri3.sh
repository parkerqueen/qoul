. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "              tri3 : LDA + MLLT + SAT Training & Decoding                 "
echo ============================================================================

steps/align_si.sh --nj "$training_nj" --cmd "$train_cmd" \
 --use-graphs true data/train data/lang exp/tri2 exp/tri2_ali

steps/train_sat.sh --cmd "$train_cmd" \
 $numLeavesSAT $numGaussSAT data/train data/lang exp/tri2_ali exp/tri3

utils/mkgraph.sh data/lang exp/tri3 exp/tri3/graph

steps/decode_fmllr.sh --nj "$decoding_nj" --cmd "$decode_cmd" \
 exp/tri3/graph data/test exp/tri3/decode