use super::super::d3dfile::*;
use json::JsonValue;

fn d3dbuffer_to_json(buffer: &D3DBuffer, buffer_as_base64: bool) -> json::JsonValue {
    json::object! {
        type: buffer.r#type.clone(),
        qty: buffer.qty,
        stride: buffer.stride,
        data: if buffer_as_base64 {
            JsonValue::String(base64::encode(buffer.as_bytes()))
        } else {
            JsonValue::Array(buffer.to_json_number())
        }
    }
}

fn pallete_to_json(pallete: &BonePallete) -> json::JsonValue {
    json::object! {
        bones: pallete.bones.iter().map(|v| {
            let number = json::number::Number::from(*v);
            JsonValue::Number(number)
        }).collect::<Vec<_>>()
    }
}

pub fn d3dfile_to_json(d3dfile: &D3DFile, buffer_as_base64: bool) -> json::JsonValue {
    let mut json = json::object! {};

    json["name"] = JsonValue::String(d3dfile.name.clone());
    json["bbox"] = json::object! {
        minx: d3dfile.bbox.minx,
        miny: d3dfile.bbox.miny,
        minz: d3dfile.bbox.minz,
        maxx: d3dfile.bbox.maxx,
        maxy: d3dfile.bbox.maxy,
        maxz: d3dfile.bbox.maxz,
    };

    json["meshes"] = JsonValue::Array(vec![]);
    for d3dmesh in d3dfile.meshes.iter() {
        let mut mesh = json::object! {};
        mesh["bbox"] = json::object! {
            minx: d3dmesh.bbox.minx,
            miny: d3dmesh.bbox.miny,
            minz: d3dmesh.bbox.minz,
            maxx: d3dmesh.bbox.maxx,
            maxy: d3dmesh.bbox.maxy,
            maxz: d3dmesh.bbox.maxz,
        };
        mesh["vertices"] = JsonValue::Array(vec![
            JsonValue::Number(d3dmesh.vertices[0].into()),
            JsonValue::Number(d3dmesh.vertices[1].into()),
        ]);
        mesh["index_start"] = JsonValue::Number(d3dmesh.index_start.into());
        mesh["tri_count"] = JsonValue::Number(d3dmesh.tri_count.into());
        mesh["bone_pallete"] = JsonValue::Number(d3dmesh.bone_pallete.into());

        mesh["maps"] = JsonValue::Array(vec![]);
        for d3dmap in d3dmesh.maps.iter() {
            let _ = mesh["maps"].push(json::object! {
                type: d3dmap.r#type.clone(),
                name: d3dmap.name.clone()
            });
        }

        let _ = json["meshes"].push(mesh);
    }

    json["palletes"] = JsonValue::Array(vec![]);
    for pallete in &d3dfile.palletes {
        let buffer_json = pallete_to_json(pallete);
        let _ = json["palletes"].push(buffer_json);
    }

    json["buffers"] = JsonValue::Array(vec![]);
    for d3dbuffer in d3dfile.buffers.iter() {
        let buffer_json = d3dbuffer_to_json(d3dbuffer, buffer_as_base64);
        let _ = json["buffers"].push(buffer_json);
    }

    json
}
