import gleam/dynamic/decode
import gleam/json
import gleam/list
import types/llm_type.{
  type LLMAnswer, LLMMessage, LLMResponseChoice, new_llm_answer,
}

// TODO: parse total tokens + fix timestamp conversion

pub fn decode_llm_call(payload: String) -> Result(LLMAnswer, json.DecodeError) {
  let decoder = {
    use choices <- decode.field(
      "choices",
      decode.list({
        use message <- decode.field("message", {
          use role <- decode.field("role", decode.string)
          use content <- decode.field("content", decode.string)
          decode.success(LLMMessage(role:, content:))
        })
        decode.success(LLMResponseChoice(message:))
      }),
    )

    use created <- decode.field("created", decode.int)
    case list.first(choices) {
      Ok(choice) -> {
        let llm_answer = new_llm_answer(choice.message, created, 13)
        decode.success(llm_answer)
      }
      Error(Nil) ->
        decode.failure(
          new_llm_answer(LLMMessage(role: "user", content: "error"), 0, 0),
          "choices",
        )
    }
  }
  json.parse(from: payload, using: decoder)
}
