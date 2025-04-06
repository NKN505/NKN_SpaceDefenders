using UnityEngine;

public class EarthRotation : MonoBehaviour
{
    [SerializeField] private float rotationSpeed = 10f; // Velocidad de rotación en grados por segundo

    private void Start()
    {
        // Aplicar la inclinación de la Tierra al eje de rotación
        transform.rotation = Quaternion.Euler(23.5f, 0f, 0f);
    }

    private void Update()
    {
        // Rotar continuamente alrededor del eje Y (simulando la rotación terrestre)
        transform.Rotate(Vector3.up * rotationSpeed * Time.deltaTime, Space.Self);
    }
}
