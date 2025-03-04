using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Water : MonoBehaviour
{
    [SerializeField] float frequency = 2.5f; // 周波数
    float omega; // 角振動数
    float m = 1; // 質量

    [SerializeField] float resistanceFactor = 1.5f;

    [SerializeField] float rotAccelerrationFactor = 10000;
    
    Quaternion preRot;

    Vector2 velocity = Vector2.zero;
    Vector2 position = Vector2.zero;

    Material material;
    int gradientID;

    void Start()
    {
        material = GetComponent<Renderer>().material;
        gradientID = Shader.PropertyToID("_gradient");
        
        omega = 2 * Mathf.PI * frequency;

        preRot = transform.rotation;

        position = new Vector2(transform.position.x, transform.position.z);
    }

    void Update()
    {
        SetGradientVector();
    }

    // -----------------------------------------

    void SetGradientVector()
    {
        // 加速度初期化
        Vector2 acceleration = Vector2.zero;

        // Quaternionで回転角度の取得
        Quaternion rotDiff = transform.rotation * Quaternion.Inverse(preRot);

        preRot = transform.rotation;

        if(rotDiff.w < 0)
        {
            rotDiff.x = -rotDiff.x;
            rotDiff.y = -rotDiff.y;
            rotDiff.z = -rotDiff.z;
            rotDiff.w = -rotDiff.w;
        }

        // 回転による速度変化
        acceleration += new Vector2(rotDiff.z, rotDiff.x) * rotAccelerrationFactor;

        // 単振動
        Vector2 springDir = new Vector2(
            position.x - transform.position.x, position.y - transform.position.z);
        acceleration += -1 * m * omega * omega * springDir;

        // 抵抗力
        acceleration += -1 * resistanceFactor * velocity;

        // 速度と座標に加算
        velocity += acceleration * Time.deltaTime;
        position += velocity * Time.deltaTime;

        // 保険
        position = new Vector2(
            Mathf.Clamp(position.x, -10, 10), Mathf.Clamp(position.y, -10, 10));

        // 勾配ベクトル
        Vector3 gradientVector = new Vector2(
            position.x - transform.position.x, position.y - transform.position.z);

        material.SetVector(gradientID, gradientVector);
    }
}
