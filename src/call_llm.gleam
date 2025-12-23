import errors/groq.{type APICallError}
import gleam/hackney
import gleam/http
import gleam/http/request
import gleam/io
import gleam/string
import serde/api.{request_body_to_json}
import types/message_type.{message_factory}
import types/request_body_type.{new_request_body}

pub fn call_model(
  url: String,
  model: String,
  key: String,
) -> Result(String, APICallError) {
  io.println("Calling model " <> model <> " from url " <> url <> "...")

  let assert Ok(request) = request.to(url)

  let request_body =
    new_request_body(message_factory, model, False)
    |> request_body_to_json

  let request =
    request
    |> request.set_method(http.Post)
    |> request.prepend_header("accept", "application/vnd.hmrc.1.0+json")
    |> request.prepend_header("Content-Type", "application/json")
    |> request.prepend_header("Authorization", "Bearer " <> key)
    |> request.set_body(request_body)

  case hackney.send(request) {
    Error(err) -> Error(groq.NetworkError(err))
    Ok(resp) -> {
      case resp.status {
        code if code >= 200 && code < 300 -> Ok(resp.body)
        code -> {
          io.println("error code: " <> string.inspect(code))
          Error(groq.HTTPError(status: code, body: resp.body))
        }
      }
    }
  }
}
