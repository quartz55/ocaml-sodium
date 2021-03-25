module C = Configurator.V1

let () =
  C.main ~name:"libsodium" (fun c ->
      let default : C.Pkg_config.package_conf = { libs = [ "-lsodium" ]; cflags = [] } in
      let conf =
        match C.Pkg_config.get c with
        | None -> default
        | Some pc -> (
            match C.Pkg_config.query pc ~package:"libsodium" with
            | None -> default
            | Some deps -> deps)
      in

      C.Flags.write_lines "c_flags.lines" conf.cflags;
      C.Flags.write_lines "c_flags_libs.lines" conf.libs;
      C.Flags.write_sexp "c_flags.sexp" conf.cflags;
      C.Flags.write_sexp "c_flags_libs.sexp" conf.libs
      )
