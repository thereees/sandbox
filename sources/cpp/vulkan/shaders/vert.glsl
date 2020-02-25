#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inNormal;
layout(location = 2) in vec2 inUV;
layout(location = 0) out vec3 fragColor;

layout(binding = 0) uniform UniformBufferObject {
    mat4 mvp;
    mat4 mvp2;
} ubo;

void main() {
    gl_Position = vec4(inPosition.xyz * 0.00001, 1.0);
    fragColor = vec3(inUV.xy,0);
}