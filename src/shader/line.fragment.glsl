#ifdef GL_ES
precision mediump float;
#else
#define lowp
#define mediump
#define highp
#endif

uniform lowp float u_opacity;
uniform float u_blur;

varying lowp vec4 v_color;
varying float v_linewidth;
varying vec2 v_normal;

void main() {


    // Calculate the distance of the pixel from the line in pixels.
    float dist = length(v_normal) * v_linewidth / 2.0;

    // Calculate the antialiasing fade factor. This is either when fading in
    // the line in case of an offset line (v_linewidth.t) or when fading out
    // (v_linewidth.s)
    float blur = u_blur;
    float alpha = clamp((dist - v_linewidth / 2.0) / blur, 0.0, 1.0);

    gl_FragColor = v_color * (alpha * u_opacity);
    gl_FragColor = vec4(255.0);
#ifdef OVERDRAW_INSPECTOR
    gl_FragColor = vec4(1.0);
#endif
}
