import { useState } from 'react'
import { createJob, updateJob } from './jobsApi'
import './JobForm.css'

function JobForm({ userId, job, onJobSaved }) {
const [formData, setFormData] = useState({
  company: job?.company || '',
  title: job?.title || '',
  description: job?.description || '',
})

  const [error, setError] = useState(null)
  const [errors, setErrors] = useState({})
  const [submitting, setSubmitting] = useState(false)

  function handleChange(event) {
    const { name, value } = event.target

    setFormData((current) => ({
      ...current,
      [name]: value,
    }))
  }

  function validateForm() {
    const errors = {}

    if (!formData.company.trim()) {
      errors.company = 'Company is required'
    }

    if (!formData.title.trim()) {
      errors.title = 'Title is required'
    }

    if (!formData.description.trim()) {
      errors.description = 'Description is required'
    }

    return errors
  }

  async function handleSubmit(event) {
    event.preventDefault()

    const validationErrors = validateForm()

    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors)
      return
    }

    setSubmitting(true)
    setError(null)
    setErrors({})

    try {
      let savedJob

      console.log(userId)

      if (job) {
        savedJob = await updateJob(job.id, formData)
      } else {
        savedJob = await createJob({
          ...formData,
          user_id: userId,
        })
      }

      onJobSaved(savedJob)
    } catch (error) {
      setError(error.message)
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <form className="job-form" onSubmit={handleSubmit}>
      <h2>{job ? 'Edit Job' : 'Add a Job'}</h2>

      {error && <p className="form-error">{error}</p>}

      <div className="form-field">
        <label htmlFor="company">Company</label>
        <input
          id="company"
          name="company"
          value={formData.company}
          onChange={handleChange}
        />
        {errors.company && (
          <p className="field-error">{errors.company}</p>
        )}
      </div>

      <div className="form-field">
        <label htmlFor="title">Title</label>
        <input
          id="title"
          name="title"
          value={formData.title}
          onChange={handleChange}
        />
        {errors.title && (
          <p className="field-error">{errors.title}</p>
        )}
      </div>

      <div className="form-field">
        <label htmlFor="description">Description</label>
        <textarea
          id="description"
          name="description"
          value={formData.description}
          onChange={handleChange}
        />
        {errors.description && (
          <p className="field-error">{errors.description}</p>
        )}
      </div>

      <button type="submit" disabled={submitting}>
        {submitting
          ? 'Saving...'
          : job
            ? 'Save Changes'
            : 'Create Job'}
      </button>
    </form>
  )
}

export default JobForm