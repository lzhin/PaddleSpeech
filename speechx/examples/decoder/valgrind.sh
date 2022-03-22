#!/bin/bash

# this script is for memory check, so please run ./run.sh first.

set +x
set -e

. ./path.sh

if [ ! -d ${SPEECHX_TOOLS}/valgrind/install ]; then
  echo "please install valgrind in the speechx tools dir.\n" 
  exit 1
fi

model_dir=../paddle_asr_model
feat_wspecifier=./feats.ark
cmvn=./cmvn.ark

valgrind --tool=memcheck --track-origins=yes --leak-check=full --show-leak-kinds=all \
  offline_decoder_main \
  --feature_respecifier=ark:$feat_wspecifier \
  --model_path=$model_dir/avg_1.jit.pdmodel \
  --param_path=$model_dir/avg_1.jit.pdparams \
  --dict_file=$model_dir/vocab.txt \
  --lm_path=$model_dir/avg_1.jit.klm

