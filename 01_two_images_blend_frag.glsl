#version 300 es
precision mediump float;

uniform sampler2D u_texture1;
uniform sampler2D u_texture2;
uniform sampler2D u_mask;

in vec2 v_uv;
out vec4 fragColor;

void main() {

    vec4 colorTexture1 = texture(u_texture1, v_uv);
    vec4 colorTexrure2 = texture(u_texture2, v_uv);
    float maskAlpha = texture(u_mask, v_uv).r;
    fragColor = mix(colorTexrure2, colorTexture1, maskAlpha);
}