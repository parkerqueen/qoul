. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "                 tri2 : LDA + MLLT Training & Decoding                    "
echo ============================================================================

steps/align_si.sh --nj "$training_nj" --cmd "$train_cmd" \
  data/train data/lang exp/tri1 exp/tri1_ali

steps/train_lda_mllt.sh --cmd "$train_cmd" \
 $numLeavesMLLT $numGaussMLLT data/train data/lang exp/tri1_ali exp/tri2

utils/mkgraph.sh data/lang exp/tri2 exp/tri2/graph

steps/decode.sh --nj "$decoding_nj" --cmd "$decode_cmd" \
 exp/tri2/graph data/test exp/tri2/decode