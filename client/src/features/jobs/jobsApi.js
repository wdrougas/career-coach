export async function getJobs() {
  const response = await fetch('http://localhost:3000/jobs')

  if (!response.ok) {
    throw new Error('Failed to fetch jobs')
  }

  return response.json()
}

export async function createJob(job) {
  const response = await fetch('http://localhost:3000/jobs', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ job }),
  })

  if (!response.ok) {
    const data = await response.json()
    throw new Error(data.errors?.join(', ') || 'Failed to create job')
  }

  return response.json()
}