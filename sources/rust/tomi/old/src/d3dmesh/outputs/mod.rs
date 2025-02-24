use super::d3dfile::D3DFile;
use std::path::PathBuf;
use std::str::FromStr;

pub mod gltf;
mod json;
mod obj;

pub fn save_to(d3dfile: &mut D3DFile, output: &str, buffer_as_base64: bool, pretty_print: bool) {
    let path = PathBuf::from_str(output).unwrap();
    let ext = path.extension().unwrap();
    println!("Saving to {}", output);
    if ext == "json" {
        let json = json::d3dfile_to_json(d3dfile, buffer_as_base64);
        let json = if !pretty_print {
            format!("{}", json)
        } else {
            format!("{}", json.pretty(4))
        };
        let _ = std::fs::write(path, json);
    } else if ext == "obj" {
        obj::save_to_obj(d3dfile, path);
    } else if ext == "gltf" {
        gltf::save_to_gltf(d3dfile, path);
    } else {
        todo!();
    }
}
