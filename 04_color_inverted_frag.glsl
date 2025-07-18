#version 300 es
precision mediump float;

uniform sampler2D u_texture;

in vec2 v_uv;
out vec4 fragColor;

void main() {
    vec4 texColor = texture(u_texture, v_uv);
    texColor.rgb = 1.0 - texColor.rgb;

    fragColor = texColor;
}
