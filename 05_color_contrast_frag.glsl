#version 300 es
precision mediump float;

uniform sampler2D u_texture;
const float CONTRAST = 1.0; // Range: -1.0 to 1.0 (0.0 = no change)

in vec2 v_uv;
out vec4 fragColor;

void main() 
{
    vec4 texColor = texture(u_texture, v_uv);

    // When CONTRAST = 0, factor = 1.0 (no change)
    // When CONTRAST > 0, factor > 1.0 (increase contrast)
    // When CONTRAST < 0, factor < 1.0 (decrease contrast)
    // For each color channel, adjust relative to the midpoint (0.5)
    vec3 midpoint = texColor.rgb - 0.5;
    float contrastFactor = CONTRAST + 1.0;
    vec3 contrastedColor = 0.5 + contrastFactor * midpoint;
    
    fragColor = vec4(contrastedColor, texColor.a);
}