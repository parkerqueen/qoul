. ./cmd.sh
. ./path.sh

set -e

echo ============================================================================
echo "                Data, Lexicon & Language Preparation                     "
echo ============================================================================

utils/fix_data_dir.sh data/train
utils/fix_data_dir.sh data/test

utils/prepare_lang.sh data/local/lang '<OOV>' data/local data/lang

rm -rf data/local/tmp
mkdir data/local/tmp
ngram-count -order $lm_order -write-vocab data/local/tmp/vocab-full.txt -wbdiscount -text data/local/corpus.txt -lm data/local/tmp/lm.arpa

arpa2fst --disambig-symbol=#0 --read-symbol-table=data/lang/words.txt data/local/tmp/lm.arpa data/lang/G.fst
