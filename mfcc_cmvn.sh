. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "         MFCC Feature Extration & CMVN for Training and Test set          "
echo ============================================================================

mfccdir=mfcc

steps/make_mfcc.sh --cmd "$train_cmd" --nj $mfcc_nj data/train exp/make_mfcc/train $mfccdir
steps/compute_cmvn_stats.sh data/train exp/make_mfcc/train $mfccdir

steps/make_mfcc.sh --cmd "$train_cmd" --nj $mfcc_nj data/test exp/make_mfcc/test $mfccdir
steps/compute_cmvn_stats.sh data/test exp/make_mfcc/test $mfccdir

utils/fix_data_dir.sh data/train
utils/validate_data_dir.sh data/train

utils/fix_data_dir.sh data/test
utils/validate_data_dir.sh data/test