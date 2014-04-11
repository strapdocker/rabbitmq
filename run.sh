#!/bin/bash
if [ ! -f /.rabbitmq_password_set ]; then

PASS=admin
_word=$( [ ${PASS} ] && echo "preset" || echo "random" )
echo "=> Securing RabbitMQ with a ${_word} password"
cat > /etc/rabbitmq/rabbitmq.config <<EOF
[
	{rabbit, [{default_user, <<"admin">>},{default_pass, <<"$PASS">>}]}
].
EOF

echo "=> Done!"
touch /.rabbitmq_password_set

echo "========================================================================"
echo "You can now connect to this RabbitMQ server using, for example:"
echo ""
echo "    rabbitmqadmin -u admin -p $PASS -H <host> -P <port> list vhosts"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
fi

exec /usr/sbin/rabbitmq-server