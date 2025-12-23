import gleam/json
import serde/message.{message_to_json}
import types/request_body_type.{type RequestBody}

pub fn request_body_to_json(body: RequestBody) -> String {
  json.object([
    #("messages", json.array(body.messages, message_to_json)),
    #("model", json.string(body.model)),
    #("stream", json.bool(body.stream)),
  ])
  |> json.to_string
}
