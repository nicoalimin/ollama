from alpine:latest AS dev

COPY . /app
RUN apk update
RUN apk add cmake go bash git
ENV OLLAMA_SKIP_PATCHING true
WORKDIR /app
RUN go generate ./...
RUN go build .

from alpine:latest
COPY --from=dev ./ollama .
EXPOSE 11434
ENV OLLAMA_HOST 0.0.0.0

ENTRYPOINT ["/bin/ollama"]
CMD ["serve"]