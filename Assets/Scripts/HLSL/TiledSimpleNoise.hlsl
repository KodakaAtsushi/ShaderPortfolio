inline float2 modulo(float2 value, float2 scale)
{
    return frac(value/scale)*scale;
}

inline float Unity_SimpleNoise_RandomValue_float (float2 uv)
{
    return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453);
}

inline float Unity_SimpleNnoise_Interpolate_float (float a, float b, float t)
{
    return (1.0-t)*a + (t*b);
}

inline float Unity_SimpleNoise_ValueNoise_float (float2 uv, float Period)
{
    float2 i = floor(uv);
    float2 f = frac(uv);
    f = f * f * (3.0 - 2.0 * f);
    //uv = abs(frac(uv) - 0.5); //この行はオリジナルに存在するが無意味なので削除
    float2 c0 = i + float2(0.0, 0.0);
    float2 c1 = i + float2(1.0, 0.0);
    float2 c2 = i + float2(0.0, 1.0);
    float2 c3 = i + float2(1.0, 1.0);
    c0 = modulo(c0, Period);
    c1 = modulo(c1, Period);
    c2 = modulo(c2, Period);
    c3 = modulo(c3, Period);
    float r0 = Unity_SimpleNoise_RandomValue_float(c0);
    float r1 = Unity_SimpleNoise_RandomValue_float(c1);
    float r2 = Unity_SimpleNoise_RandomValue_float(c2);
    float r3 = Unity_SimpleNoise_RandomValue_float(c3);
    float bottomOfGrid = Unity_SimpleNnoise_Interpolate_float(r0, r1, f.x);
    float topOfGrid = Unity_SimpleNnoise_Interpolate_float(r2, r3, f.x);
    float t = Unity_SimpleNnoise_Interpolate_float(bottomOfGrid, topOfGrid, f.y);
    return t;
}

void TiledSimpleNoise_float(float2 UV, float Scale, out float Out)
{
    float t = 0.0;
    float2 uv = UV*Scale;
    float Period = Scale;           // since the freq below can be 4 maximum.

    float tiling = pow(2.0, float(0)); // タイリングに変更
    float amp = pow(0.5, float(1)); // 大きなヤマは一番影響がでかい
    t += Unity_SimpleNoise_ValueNoise_float(float2(uv.x*tiling, uv.y*tiling), Period)*amp;

    tiling = pow(2.0, float(1));
    amp = pow(0.5, float(2));
    t += Unity_SimpleNoise_ValueNoise_float(float2(uv.x*tiling, uv.y*tiling), Period)*amp;

    // 最大1辺が4倍（4つのタイルで埋まってる）ため、scaleを4の倍数にしないと
    // uv.x*tillingの値がきれいに割り切れず、テクスチャの境目が見えてしまう？
    tiling = pow(2.0, float(2)); // タイリング増やして繰り返しになってる
    amp = pow(0.5, float(3)); // 影響が小さい
    t += Unity_SimpleNoise_ValueNoise_float(float2(uv.x*tiling, uv.y*tiling), Period)*amp;

    Out = t;
}