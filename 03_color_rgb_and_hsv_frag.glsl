#version 300 es
precision mediump float;

uniform sampler2D u_texture;
uniform float u_time; // Time in seconds

in vec2 v_uv;

out vec4 fragColor;

// Function to convert RGB to HSV
vec3 rgb2hsv(vec3 c) 
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

// Function to convert HSV to RGB
vec3 hsv2rgb(vec3 c) 
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() 
{
    // Sample the texture
    vec4 texColor = texture(u_texture, v_uv);
    
    // Convert to HSV
    vec3 hsv = rgb2hsv(texColor.rgb);
    
    // Rotate the hue based on time (complete rotation every 5 seconds)
    float hueRotation = fract(u_time / 5.0);
    hsv.x = fract(hsv.x + hueRotation); // Adjust the HSV color .x to apply hue rotation.
    
    // Convert back to RGB
    vec3 rgb = hsv2rgb(hsv);
    
    // Output the final color (TODO: apply calculated rgb color not blue color)
    fragColor = vec4(rgb, texColor.a);
}