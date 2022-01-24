create table if not exists message (
	id bigserial primary key,
	platform varchar,
	protocol varchar,
	message_size integer,
	send_time timestamp,
	return_time timestamp,
	interval_time integer,
	message_delta integer,
	messages_sent integer,
	messages_received integer
)