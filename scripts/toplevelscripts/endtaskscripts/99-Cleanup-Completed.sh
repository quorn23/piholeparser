#!/bin/bash
## This Is The End Of The Cleanup Script

## Variables
script_dir=$(dirname $0)
source "$script_dir"/../../scriptvars/staticvariables.var

echo ""

timestamp=$(echo `date`)
echo "* Script completed at $timestamp" | tee --append $RECENTRUN &>/dev/null
