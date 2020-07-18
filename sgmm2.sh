. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "                        SGMM2 Training & Decoding                         "
echo ============================================================================

steps/align_fmllr.sh --nj "$training_nj" --cmd "$train_cmd" \
 data/train data/lang exp/tri3 exp/tri3_ali

steps/train_ubm.sh --cmd "$train_cmd" \
 $numGaussUBM data/train data/lang exp/tri3_ali exp/ubm4

steps/train_sgmm2.sh --cmd "$train_cmd" $numLeavesSGMM $numGaussSGMM \
 data/train data/lang exp/tri3_ali exp/ubm4/final.ubm exp/sgmm2_4

utils/mkgraph.sh data/lang exp/sgmm2_4 exp/sgmm2_4/graph

steps/decode_sgmm2.sh --nj "$decoding_nj" --cmd "$decode_cmd"\
 --transform-dir exp/tri3/decode exp/sgmm2_4/graph data/test \
 exp/sgmm2_4/decode