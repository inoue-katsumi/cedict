#!/usr/bin/env bash
unzip -p cedict_1_0_ts_utf-8_mdbg.zip cedict_ts.u8 |
  awk -F ' |\\[|\\]' \
    '$(length($2)+5) ~ /^\// \
       {for(i=0;i<length($2);i++){py=$(i+4);if(length(py)>1) \
          printf("%s %s\n",substr($2,i+1,1),py)}}' |
  q 'select c1,c2||"+"||count(*) from - group by c1,c2' |
  q -D $'\t' 'select c1,group_concat(distinct c2) from - group by c1'
