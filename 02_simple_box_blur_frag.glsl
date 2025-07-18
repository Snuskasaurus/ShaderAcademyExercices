#version 300 es
precision mediump float;

// Fixed constants as requested
const float BLUR_RADIUS = 12.0;               // Fixed blur radius

// Texture uniform
uniform sampler2D u_texture; // The texture to blur
uniform vec2 u_resolution;

in vec2 v_uv;     // Texture coordinates
out vec4 fragColor;

void main() 
{
    vec2 pixel = 1.0 / u_resolution;
    
    // Initialize color
    vec4 color = vec4(0.0);
    float nbTetrievedTexels = 0.0;

    // Simple box blur using the fixed radius
    for (float x = -BLUR_RADIUS; x <= BLUR_RADIUS; x++) 
    {
        for (float y = -BLUR_RADIUS; y <= BLUR_RADIUS; y++) 
        {
            // Sample point
            vec2 samplePoint = v_uv + vec2(x, y) * pixel;
            color += texture(u_texture, samplePoint);
            nbTetrievedTexels++;
        }
    }
    color = color / nbTetrievedTexels;

    // Output the blurred color
    fragColor = color;
}