using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(SphereCollider))]
public class Shield : MonoBehaviour
{
    Material material;

    void Start()
    {
        material = GetComponent<Renderer>().material;
    }

    void OnCollisionEnter(Collision collision)
    {
        material.SetFloat("_startTime", Time.time);

        Vector3 hitDirection = collision.contacts[0].point - transform.position;
        material.SetVector("_hitDirection", hitDirection);
    }
}
