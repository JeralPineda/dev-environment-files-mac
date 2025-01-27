return {
  "L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
  config = function()

    local ls = require("luasnip")
    local fmt = require("luasnip.extras.fmt").fmt
    local rep = require("luasnip.extras").rep

    local i = ls.insert_node
    local f = ls.function_node
    local s = ls.s
    local c = ls.c
    local types = require("luasnip.util.types")
    local d = ls.dynamic_node
    local sn = ls.snippet_node

    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "choiceNode", "Comment" } },
          },
        },
      },
      ext_base_prio = 300,
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })

    local title_case = function(index)
      return f(function(arg)
        return string.upper(string.sub(arg[1][1], 1, 1)) .. string.sub(arg[1][1], 2)
      end, { index })
    end

    ls.add_snippets("react", {
      s("use", fmt("const [{}, set{}] = React.useState({});", { i(1, ""), title_case(1), i(2, "") })),
  
      -- s("rfc", fmt([[
      --   export const {} = () => {{
      --     {}
      --     return (
      --       <>
      --         {}
      --       </>
      --     );
      --   }};
      --   ]], { i(1, ""), i(2, ""), i(3, "") })),
        
        s("c-r", fmt([[
        export const {1} = () => {{
          return (
            <div>
              {1}
            </div>
          );
        }};
        ]], {
           -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

        s("ce-r", fmt([[
        const {1} = () => {{
          return (
            <div>
              {1}
            </div>
          );
        }};

        export default {1};
        ]], {
           -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

        s("fc-r", fmt([[
        export function {1}() {{
          return (
            <div>
              {1}
            </div>
          );
        }};
        ]], {
          -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

        s("fc-p", fmt([[
        interface {1}Props {{
          
        }};

        export function {1}() {{
          return (
            <div>
              {1}
            </div>
          );
        }};
        ]], {
           -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

         s("fce-r", fmt([[
        export default function {1}() {{
          return (
            <div>
              {1}
            </div>
          );
        }};
        ]], {
           -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

        s("fce-p", fmt([[
        interface {1}Props {{
          
        }};

        export default function {1}() {{
          return (
            <div>
              {1}
            </div>
          );
        }};
        ]], {
           -- Lógica para capturar el nombre del archivo y capitalizarlo
         f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
        end),
        })),

        s("fc-d", fmt([[
        export function {1}() {{
          return (
            <div>
            {1}
            </div>
          );
        }};
        ]], {
          -- Lógica para capturar el nombre de la carpeta
          f(function(_, snip)
            local folder_path = vim.fn.expand("%:p:h") -- Obtiene la ruta del directorio donde está el archivo
            local folder_name = folder_path:match("([^/\\]+)$") -- Obtiene el nombre de la carpeta (compatible con Unix y Windows)
            
            -- Retorna el nombre de la carpeta capitalizado
            return string.upper(string.sub(folder_name, 1, 1)) .. string.sub(folder_name, 2)
          end),
        })),

        s("fce-d", fmt([[
        export default function {1}() {{
          return (
            <div>
            {1}
            </div>
          );
        }};
        ]], {
          -- Lógica para capturar el nombre de la carpeta
          f(function(_, snip)
            local folder_path = vim.fn.expand("%:p:h") -- Obtiene la ruta del directorio donde está el archivo
            local folder_name = folder_path:match("([^/\\]+)$") -- Obtiene el nombre de la carpeta (compatible con Unix y Windows)
            
            -- Retorna el nombre de la carpeta capitalizado
            return string.upper(string.sub(folder_name, 1, 1)) .. string.sub(folder_name, 2)
          end),
        })),

       s("clg-rn", fmt(
        "console.log('🚀 {} -> #{} ~ {}', JSON.stringify({}, null, 2));", {
          f(function(_, snip) return snip.env.TM_FILENAME end),   -- Nombre del archivo
          f(function(_, snip) return snip.env.TM_LINE_NUMBER end), -- Número de línea
          f(function() 
            local selection = vim.fn.getreg('"')
            return selection ~= "" and selection or "NO_SELECTION"  -- Si no hay selección, muestra "NO_SELECTION"
          end), -- Inserta la selección visual o un valor predeterminado
          f(function() return vim.fn.getreg('"') end), -- Inserta la variable seleccionada directamente
        }
      )),

       s("clg-r", fmt(
        "console.log('🚀 {} -> #{} ~ {}', {});", {
          f(function(_, snip) return snip.env.TM_FILENAME end),   -- Nombre del archivo
          f(function(_, snip) return snip.env.TM_LINE_NUMBER end), -- Número de línea
          f(function() 
            local selection = vim.fn.getreg('"')
            return selection ~= "" and selection or "NO_SELECTION"  -- Si no hay selección, muestra "NO_SELECTION"
          end), -- Inserta la selección visual o un valor predeterminado
          f(function() return vim.fn.getreg('"') end), -- Inserta la variable seleccionada directamente
        }
      )),

      -- s("clg-t", fmt(
      --   "console.log('🚀 {} -> #{} ~ {}', {});", {
      --     f(function(_, snip) return snip.env.TM_FILENAME end),   -- Nombre del archivo
      --     f(function(_, snip) return snip.env.TM_LINE_NUMBER end), -- Número de línea
      --     f(function() return vim.fn.getreg('"') or "variable" end), -- Inserta la selección visual (o "variable" si está vacía)
      --     i(1, "")  -- Nodo de inserción para la variable opcional
      --   }
      -- ))

      s("rn-page-ed", fmt([[
      import {{ StyleSheet, Text, View }} from "react-native";

      const {1} = () => {{
        return (
          <View style={{styles.container}}>
            <Text>{1}</Text>
          </View>
        );
      }};

      export default {1};

      const styles = StyleSheet.create({{
        container: {{
          flex: 1,
        }},
      }});
      ]], {
        -- Lógica para capturar el nombre del archivo o carpeta y usar "Page" si el archivo es index
        f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          if name == "index" then
            -- Si el archivo es "index.js", usamos "Page" como nombre de la función
            return "Page"
          else
            -- Si el archivo no es "index.js", usamos el nombre del archivo capitalizado
            return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
          end
        end),
      })),

      s("rn-page", fmt([[
      import {{ StyleSheet, Text, View }} from "react-native";

      export default function {1}() {{
        return (
          <View style={{styles.container}}>
            <Text>{1}</Text>
          </View>
        );
      }};

      const styles = StyleSheet.create({{
        container: {{
          flex: 1,
        }},
      }});
      ]], {
        -- Lógica para capturar el nombre del archivo o carpeta y usar "Page" si el archivo es index
        f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          if name == "index" then
            -- Si el archivo es "index.js", usamos "Page" como nombre de la función
            return "Page"
          else
            -- Si el archivo no es "index.js", usamos el nombre del archivo capitalizado
            return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
          end
        end),
      })),

      s("rn-page-p", fmt([[
      import {{ StyleSheet, Text, View }} from "react-native";

      interface {1}Props {{
        
      }};

      export default function {1}() {{
        return (
          <View style={{styles.container}}>
            <Text>{1}</Text>
          </View>
        );
      }};

      const styles = StyleSheet.create({{
        container: {{
          flex: 1,
        }},
      }});
      ]], {
        -- Lógica para capturar el nombre del archivo o carpeta y usar "Page" si el archivo es index
        f(function(_, snip)
          local filename = vim.fn.expand("%:t") -- Obtiene el nombre del archivo actual (con extensión)
          local name = filename:match("^(.-)%.") -- Elimina la extensión del archivo

          if name == "index" then
            -- Si el archivo es "index.js", usamos "Page" como nombre de la función
            return "Page"
          else
            -- Si el archivo no es "index.js", usamos el nombre del archivo capitalizado
            return string.upper(string.sub(name, 1, 1)) .. string.sub(name, 2)  -- Capitaliza el nombre
          end
        end),
      })),

      s("rn-page-d", fmt([[
        import {{ StyleSheet, Text, View }} from "react-native";

        const {1} = () => {{
          return (
            <View style={{styles.container}}>
              <Text>{1}</Text>
            </View>
          );
        }};

        export default {1};

        const styles = StyleSheet.create({{
          container: {{
            flex: 1,
          }},
        }});
        ]], {
        -- Lógica para capturar el nombre de la carpeta
        f(function(_, snip)
          local folder_path = vim.fn.expand("%:p:h") -- Obtiene la ruta del directorio donde está el archivo
          local folder_name = folder_path:match("([^/\\]+)$") -- Obtiene el nombre de la carpeta (compatible con Unix y Windows)
          
          -- Retorna el nombre de la carpeta capitalizado
          return string.upper(string.sub(folder_name, 1, 1)) .. string.sub(folder_name, 2)
        end),
      })),

      s("rn-page-d-ed", fmt([[
        import {{ StyleSheet, Text, View }} from "react-native";

        export default function {1}(){{
          return (
            <View style={{styles.container}}>
              <Text>{1}</Text>
            </View>
          );
        }};

        const styles = StyleSheet.create({{
          container: {{
            flex: 1,
          }},
        }});
        ]], {
        -- Lógica para capturar el nombre de la carpeta
        f(function(_, snip)
          local folder_path = vim.fn.expand("%:p:h") -- Obtiene la ruta del directorio donde está el archivo
          local folder_name = folder_path:match("([^/\\]+)$") -- Obtiene el nombre de la carpeta (compatible con Unix y Windows)
          
          -- Retorna el nombre de la carpeta capitalizado
          return string.upper(string.sub(folder_name, 1, 1)) .. string.sub(folder_name, 2)
        end),
      }))

    
    }, { key = "react", })

    ls.add_snippets("javascript", {
      s("rfc", fmt([[
        export const {} = () => {{
          {}
          return (
            <>
              {}
            </>
          );
        }};
        ]], { i(1, ""), i(2, ""), i(3, "") })),
        
      s("rfcp", fmt([[

        type {}Props = {{
          {}
        }};

        export const {} = ({{ {} }}: {}Props) => {{
          {}
          return (
            <>{}</>
          );
        }};
        ]], { i(1, ""), i(2, ""), rep(1), i(3, ""), rep(1), i(4, ""), i(5, "") })),

      s("import", fmt([[import {{ {} }} from "{}";]], { i(1, ""), i(2, "") })),
      s("if", fmt(
        [[
          if ({}) {{
            {}
          }}
        ]], { i(1, ""), i(2, "") })),
    }, {
      key = "javascript",
    })

    ls.add_snippets("astro", {
      s("html5", fmt([[
        <!DOCTYPE html>
        <html lang="en">
          <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>{}</title>
          </head>
          
          <body>
            <h1>{}</h1>
          </body>
        </html>
      ]], { i(1, ""), i(2, "") }))
    }, {
      key = "astro",
    })

    ls.add_snippets("typescript", {

      s("rfc", fmt([[
        export const {} = () => {{
          {}
          return (
            <>
              {}
            </>
          );
        }};
        ]], { i(1, ""), i(2, ""), i(3, "") })),
        
      s("rfcp", fmt([[

        type {}Props = {{
          {}
        }};

        export const {} = ({{ {} }}: {}Props) => {{
          {}
          return (
            <>{}</>
          );
        }};
        ]], { i(1, ""), i(2, ""), rep(1), i(3, ""), rep(1), i(4, ""), i(5, "") })),
        
      s("type",
        fmt([[
        type {} = {{
          {}
        }};
        ]], { i(1, ""), i(2, "") })),
      
    }, { key = "typescript", })

    ls.add_snippets("lua", {
      s("snip", fmt([[s("{}", fmt({}), {{ {} }})]], { i(1, ""), i(2, ""), i(3, "") })),
      s("test", fmt([[{} {}]], { i(1, ""), title_case(1) })),
    }, { key = "lua", })
    
    ls.filetype_extend("javascriptreact", { "react", "javascript", "html", })
    ls.filetype_extend("typescriptreact", { "react", "javascript", "html", })
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("javascript", { "javascript" })
  end,
}
