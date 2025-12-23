import types/message_type.{type Message}

pub type RequestBody {
  RequestBody(messages: List(Message), model: String, stream: Bool)
}

pub fn new_request_body(
  message_factory: fn() -> List(Message),
  model: String,
  stream: Bool,
) -> RequestBody {
  let msgs = message_factory()
  RequestBody(msgs, model, stream)
}
