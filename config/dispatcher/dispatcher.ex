defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ],
    sparql: [ "application/sparql-results+json" ],
    any: [ "*/*" ]
  ]
  options "/*path", _ do
    conn
    |> Plug.Conn.put_resp_header( "access-control-allow-headers", "content-type,accept" )
    |> Plug.Conn.put_resp_header( "access-control-allow-methods", "*" )
    |> send_resp( 200, "{ \"message\": \"ok\" }" )
  end
  define_layers [ :static, :sparql, :frontend_fallback]

  # frontend
  match "/index.html", %{ layer: :static } do
    forward conn, [], "http://frontend/index.html"
  end

  get "/assets/*path",  %{ layer: :static } do
    forward conn, path, "http://frontend/assets/"
  end

  get "/@appuniversum/*path", %{ layer: :static} do
    forward conn, path, "http://frontend/@appuniversum/"
  end


  get "/sparql", %{ layer: :static, accept: %{ html: true} } do
    forward conn, [], "http://frontend/index.html"
  end

  ###############
  # SPARQL
  ###############
  match "/sparql", %{ layer: :sparql, accept: %{ sparql: true} } do
    forward conn, [], "http://database:8890/sparql"
  end


  ##############################################
  # METIS
  ##############################################

  get "/uri-info/*path", %{ accept: %{ json: true } } do
    forward conn, path, "http://uri-info/"
  end

  get "/resource-labels/*path", %{ accept: %{ json: true } } do
    forward conn, path, "http://resource-labels-cache/"
  end

  get "/resource-labels/*path" do
    Proxy.forward conn, path, "http://resource-labels/"
  end


  
  match "/*path", %{ layer: :frontend_fallback, accept: %{ any: true } } do
    forward conn, [], "http://frontend/index.html"
  end
end
