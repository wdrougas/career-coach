export async function getJobs() {
  const response = await fetch('http://localhost:3000/jobs')

  if (!response.ok) {
    throw new Error('Failed to fetch jobs')
  }

  return response.json()
}

export async function getJob(id) {
  const response = await fetch(`http://localhost:3000/jobs/${id}`)

  if (!response.ok) {
    throw new Error('Failed to fetch job')
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

export async function updateJob(id, job) {
  const response = await fetch(`http://localhost:3000/jobs/${id}`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ job }),
  })

  if (!response.ok) {
    const data = await response.json()
    throw new Error(data.errors?.join(', ') || 'Failed to update job')
  }

  return response.json()
}

export async function deleteJob(id) {
  const response = await fetch(`http://localhost:3000/jobs/${id}`, {
    method: 'DELETE',
  })

  if (!response.ok) {
    throw new Error('Failed to delete job')
  }
}