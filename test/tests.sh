echo CONSUL=PRJ_NAME-consul.svc.${TRITON_ACCOUNT}.${TRITON_DC}.cns.joyent.com >> /src/triton/_env
python3 tests.py
