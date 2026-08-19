#!/bin/sh
set -x
echo "DIAG START"
cd /app
which alembic || true
python3 -c "
import os
print('DATABASE_URL=', os.environ.get('DATABASE_URL','')[:90])
print('REDIS_URL=', os.environ.get('REDIS_URL','')[:60])
"
echo "--- running alembic upgrade head ---"
alembic upgrade head
echo "ALEMBIC EXIT: $?"
echo "DIAG DONE"
