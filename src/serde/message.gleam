import gleam/json
import types/message_type.{type Message}

pub fn message_to_json(msg: Message) -> json.Json {
  json.object([
    #("role", json.string(msg.role)),
    #("content", json.string(msg.content)),
  ])
}
