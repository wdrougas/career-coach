export async function getJobs() {
  const response = await fetch('http://localhost:3000/jobs')

  if (!response.ok) {
    throw new Error('Failed to fetch jobs')
  }

  return response.json()
}