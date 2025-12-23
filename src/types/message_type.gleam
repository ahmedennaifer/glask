pub type Message {
  Message(role: String, content: String)
}

pub fn new_message(role: String, content: String) -> Message {
  Message(role: role, content: content)
}

pub fn message_factory() -> List(Message) {
  let msg1 = new_message("user", "Hello, how are you?")
  [msg1]
}
